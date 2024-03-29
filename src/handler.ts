require('dotenv').config();
import { createReadStream } from 'fs';
import mysqldump from 'mysqldump';
import { MyS3 } from './MyS3';
import dayjs from 'dayjs';
import { createGzip } from 'zlib';

const MAX_RETRIES = 10;

export const main = async () => {
  const isLocalEnv = !process.env.LAMBDA_TASK_ROOT;
  const dumpPath = isLocalEnv ? 'dump.sql' : '/tmp/dump.sql';

  console.log(process.env.DB_HOST);
  console.log(process.env.DB_USERNAME);
  console.log(process.env.DB_PORT);
  console.log(process.env.DB_PASSWORD);
  console.log(process.env.DB_DATABASE);

  for (let i = 0; i < MAX_RETRIES; i++) {
    try {
      await mysqldump({
        connection: {
          host: process.env.DB_HOST!,
          user: process.env.DB_USERNAME!,
          port: +process.env.DB_PORT!,
          password: process.env.DB_PASSWORD!,
          database: process.env.DB_DATABASE!,
        },
        dumpToFile: dumpPath,
      });
      break;
    } catch (e) {
      continue;
    }
  }

  console.log('Dumped to file');
  const s3 = new MyS3();

  const stream = createReadStream(dumpPath);
  const key = dayjs().format('YYYY-MM-DD HH-mm-ss');
  const writeStream = s3.getWriteStream(`${key}.sql.gz`);

  stream.pipe(createGzip()).pipe(writeStream);
  console.log('Opened S3 write stream');

  const end = new Promise((resolve) => {
    writeStream.on('finish', resolve);
  });

  await end;
  console.log('Finished writing to S3 stream');
};

main();

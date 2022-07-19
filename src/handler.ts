require('dotenv').config();
import { readFileSync } from 'fs';
import mysqldump from 'mysqldump';
import { MyS3 } from './MyS3';
import dayjs from 'dayjs';

export const main = async () => {
  const isLocalEnv = !process.env.LAMBDA_TASK_ROOT;
  const dumpPath = isLocalEnv ? 'dump.sql' : '/tmp/dump.sql';

  await mysqldump({
    connection: {
      host: process.env.DB_HOST!,
      user: process.env.DB_USERNAME!,
      password: process.env.DB_PASSWORD!,
      database: process.env.DB_DATABASE!,
    },
    dumpToFile: dumpPath,
  });

  const s3 = new MyS3();
  const content = readFileSync(dumpPath, 'utf8');

  const key = dayjs().format('YYYY-MM-DD HH-mm-ss');
  await s3.uploadContentToFile(content, `${key}.sql`);
};

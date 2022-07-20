import { S3, SharedIniFileCredentials } from 'aws-sdk';
import { WriteStream } from 's3-streams';

export class MyS3 {
  private s3!: S3;

  constructor() {
    this.initializeS3Connection();
  }

  private initializeS3Connection(): void {
    this.s3 = new S3({
      region: 'eu-west-1',
      credentials: new SharedIniFileCredentials({ profile: 'graderef' }),
    });
  }

  public getWriteStream(key: string) {
    return new WriteStream(this.s3, {
      Bucket: process.env.AWS_BUCKET!,
      Key: key,
    });
  }
}

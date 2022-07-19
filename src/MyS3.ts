require('dotenv').config();
import { S3 } from '@aws-sdk/client-s3';

export class MyS3 {
  private client!: S3;

  constructor() {
    this.initializeS3Connection();
  }

  private initializeS3Connection(): void {
    const isLocalEnv = !process.env.LAMBDA_TASK_ROOT;

    if (isLocalEnv) {
      this.client = new S3({
        region: 'eu-west-1',
        credentials: {
          accessKeyId: process.env.AWS_LOGIN_ACCESS_KEY_ID!,
          secretAccessKey: process.env.AWS_LOGIN_SECRET_ACCESS_KEY!,
        },
      });
    } else {
      this.client = new S3({
        region: 'eu-west-1',
      });
    }
  }

  public async uploadContentToFile(content: string, key: string): Promise<void> {
    return new Promise((resolve) => {
      this.client
        .putObject({
          Bucket: process.env.AWS_BUCKET!,
          Key: key,
          Body: content,
        })
        .then(() => resolve());
    });
  }
}

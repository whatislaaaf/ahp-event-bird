import { WebPlugin } from '@capacitor/core';
import { AhpEventBirdPlugin, Credentials, IsSuccess, ProgressActivity } from './definitions';

export class AhpEventBirdWeb extends WebPlugin implements AhpEventBirdPlugin {
  startProgressActivity(_: ProgressActivity): Promise<void> {
    throw new Error('Method not implemented.');
  }

  completeProgressActivity(_: ProgressActivity): Promise<void> {
    throw new Error('Method not implemented.');
  }

  async saveCredentials(_options: Credentials): Promise<IsSuccess> {
    throw new Error('Method not implemented.');
  }
}

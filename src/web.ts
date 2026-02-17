import { WebPlugin } from '@capacitor/core';

import type { AhpEventBirdPlugin } from './definitions';

export class AhpEventBirdWeb extends WebPlugin implements AhpEventBirdPlugin {
  async saveCredentials(_options: { username: string; password: string }): Promise<{ isSuccess: boolean }> {
    console.log('saveCredentials()');

    return { isSuccess: true };
  }
}

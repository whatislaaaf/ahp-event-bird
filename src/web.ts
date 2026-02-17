import { WebPlugin } from '@capacitor/core';

import type { AhpEventBirdPlugin } from './definitions';

export class AhpEventBirdWeb extends WebPlugin implements AhpEventBirdPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}

import { registerPlugin } from '@capacitor/core';

import type { AhpEventBirdPlugin } from './definitions';

const AhpEventBird = registerPlugin<AhpEventBirdPlugin>('AhpEventBird', {
  web: () => import('./web').then((m) => new m.AhpEventBirdWeb()),
});

export * from './definitions';
export { AhpEventBird };

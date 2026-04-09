import { WebPlugin } from '@capacitor/core';
import {
  AhpEventBirdPlugin,
  AppleSignInResult,
  Credentials,
  GoogleSignInResult,
  IsSuccess,
  ProgressActivity,
  WidgetSyncData,
} from './definitions';

export class AhpEventBirdWeb extends WebPlugin implements AhpEventBirdPlugin {
  pauseProgressActivity(): Promise<void> {
    throw new Error('Method not implemented.');
  }
  resumeProgressActivity(): Promise<void> {
    throw new Error('Method not implemented.');
  }

  signInWithApple(): Promise<AppleSignInResult> {
    throw new Error('Method not implemented.');
  }

  signInWithGoogle(): Promise<GoogleSignInResult> {
    throw new Error('Method not implemented.');
  }

  clearFCMToken(): Promise<void> {
    throw new Error('Method not implemented.');
  }

  getFCMToken(): Promise<{ fcmToken: string; deviceId: string }> {
    throw new Error('Method not implemented.');
  }

  syncWidgetData(_: WidgetSyncData): Promise<void> {
    throw new Error('Method not implemented.');
  }

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

import type { PluginListenerHandle } from '@capacitor/core';

export interface Credentials {
  username: string;
  password: string;
}

export interface IsSuccess {
  isSuccess: boolean;
}

export interface ProgressActivity {
  progressId: string;
  taskName: string;
  startedAt: string;
}

export interface AppleSignInResult {
  idToken: string;
  email: string;
  displayName: string;
}

export interface GoogleSignInResult {
  idToken: string;
  email: string;
  displayName: string;
}

export interface WidgetSyncData {
  tasks: string;
  totalCount: number;
  completedCount: number;
  focusTaskName?: string;
  focusStartedAt?: string;
}

export interface AppUpdateEvent {
  /** 'blocking' = minor/major behind (full red overlay); 'patch' = non-blocking soft alert */
  kind: 'blocking' | 'patch';
  currentVersion: string;
  appStoreVersion: string;
  /** App Store deep link, e.g. itms-apps://apps.apple.com/app/id6759459572 */
  appStoreUrl: string;
  releaseNotes?: string;
}

export interface AhpEventBirdPlugin {
  saveCredentials(options: Credentials): Promise<IsSuccess>;
  startProgressActivity(data: ProgressActivity): Promise<void>;
  completeProgressActivity(data: ProgressActivity): Promise<void>;
  getFCMToken(): Promise<{ fcmToken: string; deviceId: string }>;
  clearFCMToken(): Promise<void>;
  signInWithGoogle(): Promise<GoogleSignInResult>;
  signInWithApple(): Promise<AppleSignInResult>;
  pauseProgressActivity(): Promise<void>;
  resumeProgressActivity(data: { startedAt: string }): Promise<void>;
  syncWidgetData(_: WidgetSyncData): Promise<void>;
  resetPatchAlertShownToday(): Promise<void>;
  addListener(
    eventName: 'appUpdateRequired',
    listenerFunc: (event: AppUpdateEvent) => void,
  ): Promise<PluginListenerHandle>;
  removeAllListeners(): Promise<void>;
}

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

export interface AhpEventBirdPlugin {
  saveCredentials(options: Credentials): Promise<IsSuccess>;
  startProgressActivity(data: ProgressActivity): Promise<void>;
  completeProgressActivity(data: ProgressActivity): Promise<void>;
  getFCMToken(): Promise<{ fcmToken: string; deviceId: string }>;
  clearFCMToken(): Promise<void>;
  signInWithGoogle(): Promise<GoogleSignInResult>;
  signInWithApple(): Promise<AppleSignInResult>;
  pauseProgressActivity(): Promise<void>;
  resumeProgressActivity(): Promise<void>;
}

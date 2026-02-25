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

export interface AhpEventBirdPlugin {
  saveCredentials(options: Credentials): Promise<IsSuccess>;
  startProgressActivity(data: ProgressActivity): Promise<void>;
  completeProgressActivity(data: ProgressActivity): Promise<void>;
}

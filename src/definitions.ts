export interface AhpEventBirdPlugin {
  saveCredentials(options: { username: string; password: string }): Promise<{ isSuccess: boolean }>;
}

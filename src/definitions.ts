export interface AhpEventBirdPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}

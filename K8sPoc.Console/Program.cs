var counter = 0;
var max = args.Length is not 0 ? Convert.ToInt32(args[0]) : -1;
var nonSecretSetting = Environment.GetEnvironmentVariable("NON_SECRET_SETTING") ?? "[Not Set]";
var secretSetting = Environment.GetEnvironmentVariable("SECRET_SETTING") ?? "[Not Set]";
while (max is -1 || counter < max)
{
    Console.WriteLine($"Hello K8s: {++counter}");
    Console.WriteLine($"Non-Secret Setting: {nonSecretSetting}");
    Console.WriteLine($"Secret Setting: {secretSetting}");
    await Task.Delay(TimeSpan.FromMilliseconds(1000));
}
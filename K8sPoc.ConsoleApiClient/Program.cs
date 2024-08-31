using System.Net.Http;

var counter = 0;
var max = args.Length is not 0 ? Convert.ToInt32(args[0]) : -1;

//  Get Web API host name from environment variable.
var webApiHost = Environment.GetEnvironmentVariable("WEB_API_HOST");

//  Build url and create new HttpClient.
var helloUrl = $"http://{webApiHost}/helloapi";
var httpClient = new HttpClient();
Console.WriteLine($"URL: {helloUrl}");

while (max is -1 || counter < max)
{
    try
    {
        var responseBody = await httpClient.GetStringAsync(helloUrl);

        Console.WriteLine($"Hello K8s: {responseBody}");
    }
    catch (HttpRequestException e)
    {
        Console.WriteLine("\nException Caught!");
        Console.WriteLine("Message :{0} ", e.Message);
    }

    await Task.Delay(TimeSpan.FromMilliseconds(1000));
}
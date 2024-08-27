using System.Net.Http;

var counter = 0;
var max = args.Length is not 0 ? Convert.ToInt32(args[0]) : -1;
var webApiHost = Environment.GetEnvironmentVariable("WEB_API_HOST");
var helloUrl = $"http://{webApiHost}/helloapi";
var httpClient = new HttpClient();
Console.WriteLine($"URL: {helloUrl}");
while (max is -1 || counter < max)
{
    try
    {
        using HttpResponseMessage response = await httpClient.GetAsync(helloUrl);
        response.EnsureSuccessStatusCode();
        string responseBody = await response.Content.ReadAsStringAsync();
        // Above three lines can be replaced with new helper method below
        // string responseBody = await client.GetStringAsync(uri);

        Console.WriteLine($"Hello K8s: {responseBody}");
    }
    catch (HttpRequestException e)
    {
        Console.WriteLine("\nException Caught!");
        Console.WriteLine("Message :{0} ", e.Message);
    }

    await Task.Delay(TimeSpan.FromMilliseconds(1000));
}
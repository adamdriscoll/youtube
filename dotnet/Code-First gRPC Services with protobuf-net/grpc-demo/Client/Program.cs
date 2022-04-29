using Common;
using Grpc.Core;
using ProtoBuf.Grpc.Client;

var channel = new Channel($"localhost:5000", ChannelCredentials.Insecure);
var client = channel.CreateGrpcService<IService>();

var response = await client.GetResponseAsync(new Request { Id = 1, Data = "Hello" });

Console.WriteLine(response.Message);
Console.ReadLine();
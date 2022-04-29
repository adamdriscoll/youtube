using Common;
using Grpc.Core;
using ProtoBuf.Grpc.Server;

class Service : IService
{
    private readonly Server _server;
    public Service()
    {
        _server = new Server()
        {
            Ports = { new ServerPort("localhost", 5000, ServerCredentials.Insecure) },
        };

        _server.Services.AddCodeFirst<IService>(this);
        _server.Start();
    }

    public ValueTask<Response> GetResponseAsync(Request request)
    {
        return new ValueTask<Response>(new Response { Message = $"Hello, World! {request.Id}, {request.Data}" });
    }
}

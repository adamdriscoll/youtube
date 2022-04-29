using System.ServiceModel;

namespace Common;

[ServiceContract]
public interface IService
{
    ValueTask<Response> GetResponseAsync(Request request);
}

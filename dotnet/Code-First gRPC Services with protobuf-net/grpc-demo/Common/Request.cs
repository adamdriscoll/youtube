using System.Runtime.Serialization;

namespace Common;

[DataContract]
public class Request
{
    [DataMember(Order = 1)]
    public long Id { get; set; }

    [DataMember(Order = 2)]
    public string Data { get; set; }
}
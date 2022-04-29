using System.Runtime.Serialization;

namespace Common;

[DataContract]
public class Response
{

    [DataMember(Order = 1)]
    public string Message { get; set; }
}
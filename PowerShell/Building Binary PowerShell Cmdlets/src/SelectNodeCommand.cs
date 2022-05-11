using System;
using System.Management.Automation;
using HtmlAgilityPack;

namespace PSHtml
{
    [Cmdlet(VerbsCommon.Select, "Node")]
    public class SelectNodeCommand : PSCmdlet
    {
        [Parameter(Mandatory = true, ValueFromPipeline = true)]
        public HtmlDocument Document { get; set; }

        [Parameter(Mandatory = true)]
        public string XPath { get; set; }

        protected override void ProcessRecord()
        {
            var nodes = Document.DocumentNode.SelectNodes(XPath);
            WriteObject(nodes, true);
        }
    }
}
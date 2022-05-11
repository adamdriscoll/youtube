using System;
using System.Management.Automation;
using HtmlAgilityPack;

namespace PSHtml
{
    [Cmdlet(VerbsData.Import, "Website")]
    public class ImportWebsiteCommand : PSCmdlet
    {
        [Parameter(Mandatory = true)]
        public Uri Uri { get; set; }

        protected override void ProcessRecord()
        {
            var web = new HtmlWeb();
            var doc = web.Load(Uri);
            WriteObject(doc);
        }
    }
}
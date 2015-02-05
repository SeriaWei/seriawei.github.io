using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using HtmlAgilityPack;

namespace DownLoadMeiShiJ
{
    class Program
    {
        static void Main(string[] args)
        {
            XmlDocument doc = new XmlDocument();
            doc.Load("DataSource.xml");
            XmlNodeList categories = doc.GetElementsByTagName("Category");
            foreach (XmlNode category in categories)
            {
                string name = category.Attributes["name"].InnerText;
                string rename = category.Attributes["rename"].InnerText;
                foreach (XmlNode item in category.ChildNodes)
                {
                    string itemname = item.Attributes["name"].InnerText;
                    string itemrename = item.Attributes["rename"].InnerText;
                    string itemurl = item.Attributes["url"].InnerText;
                    HtmlWeb web=new HtmlWeb();
                    web.Load(itemurl);

                }
            }
        }
    }
}

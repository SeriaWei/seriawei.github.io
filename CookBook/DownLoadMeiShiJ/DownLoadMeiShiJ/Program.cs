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
            string favePath = doc.GetElementsByTagName("Categories")[0].Attributes["savepath"].InnerText;
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
                    int maxpage = 0;
                    int.TryParse(item.Attributes["maxpage"].InnerText, out maxpage);
                    for (int i = 1; i <= maxpage; i++)
                    {
                        HtmlWeb web = new HtmlWeb();
                        HtmlDocument htmldoc = web.Load(itemurl + "?&?&page=" + i);
                        HtmlNodeCollection cookItems = htmldoc.DocumentNode.SelectNodes("//*[@id=\"listtyle1_list\"]/div");
                        List<CookListItem> pageItems = new List<CookListItem>();
                        foreach (HtmlNode cookItem in cookItems)
                        {
                            CookListItem cItem = new CookListItem();
                            HtmlNode href = cookItem.SelectSingleNode("a");
                            cItem.DetailUrl = href.GetAttributeValue("href", "");
                            cItem.Name = href.GetAttributeValue("title", "");
                            cItem.ImageUrl = cookItem.SelectSingleNode("a/img").GetAttributeValue("src", "");
                            cItem.CategoryName = itemname;
                            cItem.CategoryReName = itemrename;
                            pageItems.Add(cItem);
                        }
                        string result = Newtonsoft.Json.JsonConvert.SerializeObject(pageItems);                        
                        string dir = favePath + rename + "\\";
                        if (!System.IO.Directory.Exists(dir))
                        {
                            System.IO.Directory.CreateDirectory(dir);
                        }
                        string file = dir + itemrename + "_p" + i + ".json";
                        Console.WriteLine(file);
                        System.IO.FileStream fs = new System.IO.FileStream(file, System.IO.FileMode.Create);
                        System.IO.StreamWriter writer = new System.IO.StreamWriter(fs);
                        writer.Write(Encoding.UTF8.GetString(Encoding.Default.GetBytes(result)));
                        writer.Close();
                        writer.Dispose();
                        fs.Close();
                        fs.Dispose();
                    }

                }
            }
        }
    }
}

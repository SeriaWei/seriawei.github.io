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
            Console.WriteLine("1.下载分页数据");
            Console.WriteLine("2.下载详细数据");
            Console.WriteLine("1/2 ？");
            switch (Console.ReadLine())
            {
                case "1": DownLoadPage(favePath, categories); break;
                case "2": DownLoadDetail(favePath, categories); break;
            }


        }

        private static void DownLoadDetail(string favePath, XmlNodeList categories)
        {
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
                        string dir = favePath + rename + "\\" + itemrename + "\\";
                        string file = dir + itemrename + "_p" + i + ".json";

                        List<CookListItem> items = Newtonsoft.Json.JsonConvert.DeserializeObject<List<CookListItem>>(System.IO.File.ReadAllText(file, Encoding.UTF8));
                        foreach (CookListItem cookItem in items)
                        {
                            string detailPath = dir + "detail\\";
                            if (!System.IO.Directory.Exists(detailPath))
                            {
                                System.IO.Directory.CreateDirectory(detailPath);
                            }
                            string detailFile = detailPath + System.IO.Path.GetFileName(cookItem.DetailID);
                            if (System.IO.File.Exists(detailFile)) continue;

                            HtmlWeb web = new HtmlWeb();
                            web.UserAgent = "Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.93 Safari/537.36";
                            HtmlDocument htmldoc = web.Load(cookItem.DetailUrl);
                            HtmlNode head = htmldoc.DocumentNode.SelectSingleNode("//div[@class='measure']/h2[@class='cpc_h2']");
                            if (head == null)
                                continue;
                            
                            CookDetail cookDetail = new CookDetail();
                            cookDetail.Title = Trim(head.InnerText);
                            Console.WriteLine(cookDetail.Title);
                            HtmlNodeCollection primaries = htmldoc.DocumentNode.SelectNodes("//div[@class='materials_box']/div[@class='yl zl clearfix']/ul/li");
                            if (primaries != null)
                            {
                                foreach (HtmlNode primaryItem in primaries)
                                {
                                    cookDetail.Primary.Add(Trim(primaryItem.InnerText));
                                }
                            }


                            HtmlNodeCollection auxiliaries = htmldoc.DocumentNode.SelectNodes("//div[@class='materials_box']/div[@class='yl fuliao clearfix'][1]/ul/li");
                            if (auxiliaries != null)
                            {
                                foreach (HtmlNode auxiliaryItem in auxiliaries)
                                {
                                    cookDetail.Auxiliary.Add(Trim(auxiliaryItem.InnerText));
                                }
                            }

                            HtmlNodeCollection flavorings = htmldoc.DocumentNode.SelectNodes("//div[@class='materials_box']/div[@class='yl fuliao clearfix'][2]/ul/li");
                            if (flavorings != null)
                            {
                                foreach (HtmlNode flavoringItem in flavorings)
                                {
                                    cookDetail.Flavoring.Add(Trim(flavoringItem.InnerText));
                                }
                            }

                            HtmlNodeCollection setups = htmldoc.DocumentNode.SelectSingleNode("//div[@class='measure']/div").ChildNodes;
                            foreach (HtmlNode setup in setups)
                            {
                                if (setup.Name == "#text") continue;
                                string text = Trim(setup.InnerText);
                                if (text != string.Empty)
                                {
                                    cookDetail.Setups.Add(text);
                                }
                                HtmlNode img = setup.SelectSingleNode(".//img[@class='conimg']");
                                if (img != null)
                                {
                                    cookDetail.Setups.Add("[image]:" + img.GetAttributeValue("src", ""));
                                }
                            }

                            string result = Newtonsoft.Json.JsonConvert.SerializeObject(cookDetail);

                            System.IO.FileStream fs = new System.IO.FileStream(detailFile, System.IO.FileMode.Create);
                            System.IO.StreamWriter writer = new System.IO.StreamWriter(fs, Encoding.UTF8);
                            writer.Write(result);
                            writer.Close();
                            writer.Dispose();
                            fs.Close();
                            fs.Dispose();
                        }
                    }
                }
            }
        }
        private static string Trim(string text)
        {
            if (text == null) return string.Empty;
            return text.Replace("\n", "").Replace("\r\n", "").Replace("\t", "").Replace("&nbsp;", "").Replace("&ldquo;","").Replace("\r","").Trim();
        }
        private static void DownLoadPage(string favePath, XmlNodeList categories)
        {
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
                        string dir = favePath + rename + "\\" + itemrename + "\\";
                        if (!System.IO.Directory.Exists(dir))
                        {
                            System.IO.Directory.CreateDirectory(dir);
                        }
                        string file = dir + itemrename + "_p" + i + ".json";
                        Console.WriteLine(file);
                        System.IO.FileStream fs = new System.IO.FileStream(file, System.IO.FileMode.Create);
                        System.IO.StreamWriter writer = new System.IO.StreamWriter(fs, Encoding.UTF8);
                        writer.Write(result);
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

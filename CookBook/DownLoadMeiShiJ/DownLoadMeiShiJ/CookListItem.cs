using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DownLoadMeiShiJ
{
    public class CookListItem
    {
        public string Name { get; set; }
        public string ImageUrl { get; set; }
        public string DetailUrl { get; set; }
        public string DetailID
        {
            get
            {
                if (CategoryReName != null && DetailUrl != null)
                {
                    return CategoryReName + "/detail/" + DetailUrl.Substring(DetailUrl.LastIndexOf("/") + 1).Replace(".html", ".json");
                }
                return string.Empty;
            }
        }
        public string CategoryName { get; set; }
        public string CategoryReName { get; set; }

    }
}

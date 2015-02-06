using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DownLoadMeiShiJ
{
    public class CookDetail
    {
        public CookDetail()
        {
            Primary = new List<string>();
            Auxiliary = new List<string>();
            Flavoring = new List<string>();
            Setups = new List<string>();
        }
        public string Title { get; set; }
        /// <summary>
        /// 主料
        /// </summary>
        public List<string> Primary { get; set; }
        /// <summary>
        /// 辅料
        /// </summary>
        public List<string> Auxiliary { get; set; }
        /// <summary>
        /// 调料
        /// </summary>
        public List<string> Flavoring { get; set; }

        /// <summary>
        /// 步骤
        /// </summary>
        public List<string> Setups { get; set; }
    }
}


using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace chp54.Chp86
{
    public class MenuHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            List<Menu> listMenu = new List<Menu>();
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spGetMenuData", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Menu menu = new Menu();
                    menu.Id = Convert.ToInt32(rdr["Id"]);
                    menu.MenuText = rdr["MenuText"].ToString();
                    menu.ParentId = rdr["ParentId"] != DBNull.Value
                        ? Convert.ToInt32(rdr["ParentId"]) : (int?)null;
                    menu.Active = Convert.ToBoolean(rdr["Active"]);
                    listMenu.Add(menu);
                }
            }

            List<Menu> menuTree = GetMenuTree(listMenu, null);

            JavaScriptSerializer js = new JavaScriptSerializer();
            context.Response.Write(js.Serialize(menuTree));
        }

        public List<Menu> GetMenuTree(List<Menu> list, int? parent)
        {
            return list.Where(x => x.ParentId == parent).Select(x => new Menu
            {
                Id = x.Id,
                MenuText = x.MenuText,
                ParentId = x.ParentId,
                Active = x.Active,
                List = GetMenuTree(list, x.Id)
            }).ToList();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
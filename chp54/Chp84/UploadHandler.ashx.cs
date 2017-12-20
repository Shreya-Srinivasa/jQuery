using System.IO;
using System.Web;

namespace chp54
{
    public class UploadHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            if (context.Request.Files.Count > 0)
            {
                HttpFileCollection files = context.Request.Files;
                for(int i=0; i<files.Count; i++)
                {
                    System.Threading.Thread.Sleep(1000);
                    HttpPostedFile file = files[i];
                    string fileName = context.Server.MapPath("~/Uploads/" + System.IO.Path.GetFileName(file.FileName));
                    file.SaveAs(fileName);
                }
            }
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
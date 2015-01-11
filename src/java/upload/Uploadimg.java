
package upload;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import java.sql.*;
import com.mysql.jdbc.Driver;

public class Uploadimg extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Uploadimg() {
        
    }

    public String renameImage(String ext) throws Exception
    {
        
            String query = "select max(picid)+1 from newpic";
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/computershop", "root", "root");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(query);
            rs.next();
            return  rs.getString(1)+"."+ext;
            
    }
    
    public void insertImage(String proid,String img) throws Exception
    {
        
            String query = "insert into newpic values(null,"+proid+",'"+img+"')";
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/computershop", "root", "root");
            Statement st = con.createStatement();
            st.executeUpdate(query);
            
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  boolean isMultipart = ServletFileUpload.isMultipartContent(request);
			
	        if (isMultipart) {
	        	// Create a factory for disk-based file items
	        	FileItemFactory factory = new DiskFileItemFactory();

	        	// Create a new file upload handler
	        	ServletFileUpload upload = new ServletFileUpload(factory);
	 
	            try {
	            	// Parse the request
					List /* FileItem */ items = upload.parseRequest(request);
					Iterator iterator = items.iterator();
	                while (iterator.hasNext()) {
                            System.out.println(iterator.toString());
	                    FileItem item = (FileItem) iterator.next();
	                    if (!item.isFormField()) {
	                        String fileName = item.getName();
                                //System.out.println(fileName.split("."));
                                String part[] = fileName.split("\\.");
                                for(int i=0;i<part.length;i++)
                                {
                                    System.out.println(part[i]+"-->>");
                                }
                                fileName = renameImage(part[1]);
                                
                                System.out.println(fileName);
                                //String proid = request.getParameter("proid");
                                insertImage("1", fileName);
                                //System.out.println(item.getContentType());
	                        String root = getServletContext().getRealPath("/");
	                        File path = new File(root + "/upload");
	                        if (!path.exists()) {
				boolean status = path.mkdirs();
	                        }
	                        File uploadedFile = new File(path + "/" + fileName);
	                        System.out.println(uploadedFile.getAbsolutePath());
	                        item.write(uploadedFile);
                                //PrintWriter pw = response.getWriter();
                                //pw.write("{'type':'success', 'msg':'Image Uploaded!}");
                                
	                    }
	                }
	            } catch (FileUploadException e) {
	                e.printStackTrace();
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }
	}

}
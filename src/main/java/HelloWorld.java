import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.servlet.*;
import java.util.Map;

public class HelloWorld extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
        String request = req.getQueryString();
        Map<String, String> para = Common.parseMapStr(request);
        String baseSalary = para.get("base");
        resp.getWriter().print("GET method with parameter:" + baseSalary);
    }

    /**
     * Servlet method responding to HTTP POST methods calls.
     *
     * @param request HTTP request.
     * @param response HTTP response.
     */
    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
     throws ServletException, IOException {
        response.getWriter().print("POST method (changing data) was invoked!\n");
    }

    public static void main(String[] args) throws Exception{
        Server server = new Server(Integer.valueOf(System.getenv("PORT")));
        ServletContextHandler context = new ServletContextHandler(ServletContextHandler.SESSIONS);
        context.setContextPath("/");
        server.setHandler(context);
        context.addServlet(new ServletHolder(new HelloWorld()),"/*");
        server.start();
        server.join();
    }
}
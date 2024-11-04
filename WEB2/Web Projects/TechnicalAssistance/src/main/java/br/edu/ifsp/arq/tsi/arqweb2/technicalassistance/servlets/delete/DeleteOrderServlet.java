package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.delete;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.OrderDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.DataSourceSearcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;

import static br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.Util.dispatcherForward;

@WebServlet("/home/delete/order")
public class DeleteOrderServlet extends HttpServlet {

    String url = "/home/view/order/page.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long code = Long.parseLong(req.getParameter("code"));

         DataSource dataSource = DataSourceSearcher.getInstance().getDataSource();
         OrderDao orderDao = new OrderDao(dataSource);
         if (!orderDao.delete(code)) {
             dispatcherForward(req, resp, url, "error");
             return;
         }

        dispatcherForward(req, resp, url, "success");
    }
}

package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.delete;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.CustomerDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.DataSourceSearcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;

@WebServlet("/home/delete/customer")
public class DeleteCustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int code = Integer.parseInt(req.getParameter("code"));

         DataSource dataSource = DataSourceSearcher.getInstance().getDataSource();
         CustomerDao customerDao = new CustomerDao(dataSource);
         if (!customerDao.delete((long) code)) {
             req.setAttribute("result", "error");
             resp.sendRedirect(req.getContextPath() + "/home");
             return;
         }

         req.setAttribute("result", "success");
         resp.sendRedirect(req.getContextPath() + "/home");
    }
}

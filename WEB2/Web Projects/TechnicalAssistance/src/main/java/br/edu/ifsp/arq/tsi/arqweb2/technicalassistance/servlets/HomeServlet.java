package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Customer;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Order;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.CustomerDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.OrderDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.DataSourceSearcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String result = "";
        if (session != null) {
            result = (String) session.getAttribute("result");
            session.removeAttribute("result");
        }


        OrderDao orderDao = new OrderDao(DataSourceSearcher.getInstance().getDataSource());
        List<Order> orders = orderDao.getAll();

        req.setAttribute("orders", orders);

        orders = orders.stream().filter(order -> order.getStatus().getName().equals("Concluído")).toList();
        Double price = orders.stream().mapToDouble(Order::getPrice).sum();

        String formatedPrice = String.format("R$%.2f", price);

        req.setAttribute("ordersPrice", formatedPrice);

        CustomerDao customerDao = new CustomerDao(DataSourceSearcher.getInstance().getDataSource());
        List< Customer > customers = customerDao.getAll();

        req.setAttribute("customers", customers);

        req.setAttribute("result", result);
        req.getRequestDispatcher("./pages/home/page.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}

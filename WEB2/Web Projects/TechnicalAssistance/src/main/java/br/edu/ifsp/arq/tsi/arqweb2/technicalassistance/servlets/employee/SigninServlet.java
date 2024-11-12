package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.employee;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Employee;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.EmployeeDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.DataSourceSearcher;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.Encoder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/signin")
public class SigninServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String result = "";
        if (session != null) {
            result = (String) session.getAttribute("result");
            session.removeAttribute("result");
        }
        req.setAttribute("result", result);

        req.getRequestDispatcher("/pages/signin/page.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email, password;

        try{
            email = req.getParameter("email");
            password = Encoder.encode(req.getParameter("password"));
        } catch (NumberFormatException e) {
            req.getRequestDispatcher("/pages/signin/page.jsp").forward(req, resp);
            return;
        }

         EmployeeDao employeeDao = new EmployeeDao(DataSourceSearcher.getInstance().getDataSource());
         Optional<Employee> employee = employeeDao.getByEmail(email);
         if (employee.isEmpty() || !employee.get().getPassword().equals(password)) {
             req.getRequestDispatcher("/pages/signin/page.jsp").forward(req, resp);
             return;
         }

         req.getSession().setAttribute("employeeCode", employee.get().getCode());
         resp.sendRedirect(req.getContextPath()+ "/home");
    }
}

package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.delete;

import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.Employee;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.dao.EmployeeDao;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.model.util.DataSourceSearcher;
import br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets.Util;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/home/delete/profile")
public class DeleteEmployeeServlet  extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doDelete(req, resp);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession(false);
        Long employeeCode;
        if (session == null) {
            Util.dispatcherForward(req, resp, "/signin", "error");
            return;
        }

        employeeCode = (Long) session.getAttribute("employeeCode");
        session.invalidate();

        EmployeeDao employeeDao = new EmployeeDao(DataSourceSearcher.getInstance().getDataSource());
        Optional<Employee> employee = employeeDao.getByCode(employeeCode);
        if (employee.isEmpty()) {
            Util.dispatcherForward(req, resp, "/signin", "error");
            return;
        }

        if (!employeeDao.delete(employeeCode)) {
            Util.dispatcherForward(req, resp, "/signin", "error");
            return;
        }


        Util.dispatcherForward(req, resp, "/signin", "success");
    }
}

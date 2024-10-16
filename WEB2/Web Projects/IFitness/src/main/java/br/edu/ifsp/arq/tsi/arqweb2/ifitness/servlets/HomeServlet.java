package br.edu.ifsp.arq.tsi.arqweb2.ifitness.servlets;

import br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.Activity;
import br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.User;
import br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.dao.ActivityDao;
import br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.util.DataSourceSearcher;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.Serial;
import java.util.List;

@WebServlet("/homeServlet")
public class HomeServlet extends HttpServlet{

	@Serial
	private static final long serialVersionUID = 1L;
	
	public HomeServlet() {
		super();
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		User user = (User)session.getAttribute("user");

		RequestDispatcher dispatcher;

		if(user != null) {
			ActivityDao activityDao = new ActivityDao(DataSourceSearcher.getInstance().getDataSource());
			List<Activity> userActivities = activityDao.getActivitiesByUser(user);

			req.setAttribute("userActivities", userActivities);
			req.setAttribute("name", user.getName());

			dispatcher = req.getRequestDispatcher("/home.jsp");
		}else {
			req.setAttribute("result", "loginError");
			dispatcher = req.getRequestDispatcher("/login.jsp");
		}

		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

}






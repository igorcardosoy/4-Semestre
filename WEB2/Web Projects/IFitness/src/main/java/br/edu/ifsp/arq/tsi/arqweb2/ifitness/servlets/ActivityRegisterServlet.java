package br.edu.ifsp.arq.tsi.arqweb2.ifitness.servlets;

import br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.Activity;
import br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.ActivityType;
import br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.User;
import br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.dao.ActivityDao;
import br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.util.DataSourceSearcher;
import br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.util.activities.ActivitiesReader;
import br.edu.ifsp.arq.tsi.arqweb2.ifitness.model.util.activities.ActivitiesWriter;
import com.google.gson.Gson;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.Serial;
import java.time.LocalDate;

@WebServlet("/activityRegister")
public class ActivityRegisterServlet extends HttpServlet {

	@Serial
	private static final long serialVersionUID = 1L;

	public ActivityRegisterServlet() {
		super();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		long id = Long.parseLong(req.getParameter("id"));
		ActivityType type = ActivityType.valueOf(req.getParameter("type"));
		LocalDate date = LocalDate.parse(req.getParameter("date"));
		Double distance = Double.parseDouble(req.getParameter("distance"));
		Integer duration = Integer.parseInt(req.getParameter("duration"));
		String url;
		HttpSession session = req.getSession(false);

		User user = (User) session.getAttribute("user");
		Activity activity = new Activity();
		activity.setType(type);
		activity.setDate(date);
		activity.setDistance(distance);
		activity.setDuration(duration);
		activity.setUser(user);

		ActivityDao activityDao = new ActivityDao(DataSourceSearcher.getInstance().getDataSource());

		if (id == 0) {
			if (activityDao.save(activity)) {
				req.setAttribute("result", "registered");
			}
		} else {
			activity.setId(id);
			if (activityDao.update(activity)) {
				req.setAttribute("result", "registered");
			}
		}

		url = "/activity-register.jsp";

		RequestDispatcher dispatcher = req.getRequestDispatcher(url);
		dispatcher.forward(req, resp);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		ActivityDao activityDao = new ActivityDao(DataSourceSearcher.getInstance().getDataSource());

		String action = req.getParameter("action");
		Long id = Long.parseLong(req.getParameter("activity-id"));
		String url;

		Activity activity = activityDao.getActivityById(id);
		RequestDispatcher dispatcher;
		if(activity != null) {
			if(action.equals("update")) {
				req.setAttribute("activity", activity);
				url = "/activity-register.jsp";
				dispatcher = req.getRequestDispatcher(url);
				dispatcher.forward(req, resp);
			}
			if(action.equals("remove")) {
				Boolean response = activityDao.delete(activity);
				Gson gson = new Gson();
				String json = gson.toJson(response);
				resp.setContentType("application/json");
				resp.getWriter().write(json);
			}
		}else {
			url = "/homeServlet";
			dispatcher = req.getRequestDispatcher(url);
			dispatcher.forward(req, resp);
		}

		
	}

}

package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class Util {

    public static void dispatcherForward(HttpServletRequest req, HttpServletResponse resp, String path, String message) {
        HttpSession session = req.getSession();
        session.setAttribute("result", message);

        try {
            resp.sendRedirect(req.getContextPath() + path);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}

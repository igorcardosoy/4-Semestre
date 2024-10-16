package br.edu.ifsp.arq.tsi.arqweb2.technicalassistance.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class Util {

    public static void dispatcherForward(HttpServletRequest req, HttpServletResponse resp, String path, String message) {
        req.setAttribute("message", message);
        try {
            req.getRequestDispatcher(path).forward(req, resp);
        } catch (ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }
}

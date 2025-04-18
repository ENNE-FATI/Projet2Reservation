package controllers;

import entities.ActiviteTouristique;
import services.ActivityService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "ActivityController", urlPatterns = {"/save-activity", "/delete-activity", "/activity-form", "/activities"})
public class ActivityController extends HttpServlet {
    private ActivityService activityService;

    @Override
    public void init() throws ServletException {
        activityService = new ActivityService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if (path.equals("/activity-form")) {
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                Activity activity = activityService.findById(Integer.parseInt(idStr));
                request.setAttribute("activity", activity);
            }
            request.setAttribute("allActivities", activityService.findAll());
            request.getRequestDispatcher("AdminActivityForm.jsp").forward(request, response);

        } else if (path.equals("/delete-activity")) {
            String id = request.getParameter("id");
            if (id != null) {
                activityService.delete(activityService.findById(Integer.parseInt(id)));
            }
            response.sendRedirect("activity-form");

        } else if (path.equals("/activities")) {
            request.setAttribute("allActivities", activityService.findAll());
            request.getRequestDispatcher("AdminActivityForm.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupération des champs
        String id = request.getParameter("id");
        String nom = request.getParameter("nom");
        String lieu = request.getParameter("lieu");
        String description = request.getParameter("description");
        String prixStr = request.getParameter("prix");

        double prix = Double.parseDouble(prixStr);

        Activity activity = new Activity(nom, lieu, description, prix);

        if (id == null || id.isEmpty()) {
            activityService.create(activity);
            request.getSession().setAttribute("successMessage", "Activité créée avec succès !");
        } else {
            activity.setId(Integer.parseInt(id));
            activityService.update(activity);
            request.getSession().setAttribute("successMessage", "Activité modifiée avec succès !");
        }

        response.sendRedirect("activity-form");
    }
}

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulaire d'activité - Administration</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body {
            min-height: 100vh;
            display: flex;
        }
        
        .sidebar {
            width: 250px;
            background-color: #212529;
            color: white;
            min-height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            z-index: 100;
        }
        
        .sidebar-header {
            padding: 1rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .sidebar-menu {
            padding: 1rem 0;
        }
        
        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 0.75rem 1rem;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .sidebar-menu a:hover, .sidebar-menu a.active {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }
        
        .sidebar-menu i {
            margin-right: 10px;
        }
        
        .sidebar-footer {
            padding: 1rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            position: absolute;
            bottom: 0;
            width: 100%;
        }
        
        .content {
            flex: 1;
            margin-left: 250px;
            padding: 2rem;
            background-color: #f8f9fa;
        }
        
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            margin-bottom: 2rem;
        }
        
        .table th {
            font-weight: 600;
        }
        
        .dropdown-menu {
            min-width: 8rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                position: relative;
                min-height: auto;
            }
            
            .content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h4>Administration</h4>
        </div>
        
        <div class="sidebar-menu">
            <a href="AdminDashboard.jsp">
                <i class="bi bi-speedometer2"></i> Tableau de bord
            </a>
            <a href="activities" class="active">
                <i class="bi bi-list-check"></i> Activités
            </a>
            <a href="GestionGuide.jsp">
                <i class="bi bi-people"></i> Guides
            </a>
        </div>
        
        <div class="sidebar-footer">
            <a href="Connexion.jsp" class="btn btn-outline-light w-100">
                <i class="bi bi-box-arrow-left"></i> Déconnexion
            </a>
        </div>
    </div>
    
    <!-- Content -->
    <div class="content">
        <div class="container-fluid">
            <div class="mb-4">
                <h1>
                    <c:choose>
                        <c:when test="${empty activity.id}">Ajouter une activité</c:when>
                        <c:otherwise>Modifier une activité</c:otherwise>
                    </c:choose>
                </h1>
                <p class="text-muted">
                    <c:choose>
                        <c:when test="${empty activity.id}">Créez une nouvelle activité dans la base de données</c:when>
                        <c:otherwise>Modifiez les détails de l'activité</c:otherwise>
                    </c:choose>
                </p>
            </div>
            
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            
            <!-- Formulaire d'ajout/modification -->
            <div class="card">
                <div class="card-body p-4">
                    <form id="activityForm" action="save-activity" method="POST">
                        <c:if test="${not empty activity.id}">
                            <input type="hidden" name="id" value="${activity.id}">
                        </c:if>
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="nom" class="form-label">Nom de l'activité</label>
                                <input type="text" class="form-control" id="nom" name="nom" value="${activity.nom}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="lieu" class="form-label">Lieu</label>
                                <input type="text" class="form-control" id="lieu" name="lieu" value="${activity.lieu}" required>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="4" required>${activity.description}</textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label for="prix" class="form-label">Prix (€)</label>
                            <input type="number" class="form-control" id="prix" name="prix" min="0" step="0.01" value="${empty activity.prix ? '0' : activity.prix}" required>
                        </div>
                        
                        <div class="d-flex justify-content-between mt-4">
                            <a href="activities" class="btn btn-outline-secondary">Annuler</a>
                            <button type="submit" class="btn btn-primary">
                                <c:choose>
                                    <c:when test="${empty activity.id}">Créer</c:when>
                                    <c:otherwise>Mettre à jour</c:otherwise>
                                </c:choose>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- Liste des activités -->
            <div class="card">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Liste des activités</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Nom</th>
                                    <th>Lieu</th>
                                    <th>Prix</th>
                                    <th>Description</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty allActivities}">
                                        <tr>
                                            <td colspan="5" class="text-center">Aucune activité trouvée</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="activityItem" items="${allActivities}">
                                            <tr>
                                                <td>${activityItem.nom}</td>
                                                <td>${activityItem.lieu}</td>
                                                <td><fmt:formatNumber value="${activityItem.prix}" type="currency" currencySymbol="€" /></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${fn:length(activityItem.description) > 50}">
                                                            ${fn:substring(activityItem.description, 0, 50)}...
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${activityItem.description}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-end">
                                                    <a href="activity-form?id=${activityItem.id}" class="btn btn-sm btn-outline-primary me-1">
                                                        <i class="bi bi-pencil"></i>
                                                    </a>
                                                    <button class="btn btn-sm btn-outline-danger" 
                                                            data-bs-toggle="modal" 
                                                            data-bs-target="#deleteModal" 
                                                            data-id="${activityItem.id}"
                                                            data-nom="${activityItem.nom}">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Delete Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Confirmer la suppression</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Êtes-vous sûr de vouloir supprimer l'activité <span id="activityName"></span> ? Cette action ne peut pas être annulée.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                    <a href="#" class="btn btn-danger" id="confirmDelete">Supprimer</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Gestion de la suppression
        const deleteModal = document.getElementById('deleteModal');
        if (deleteModal) {
            deleteModal.addEventListener('show.bs.modal', function (event) {
                // Bouton qui a déclenché la modal
                const button = event.relatedTarget;
                
                // Récupérer les données
                const activityId = button.getAttribute('data-id');
                const activityName = button.getAttribute('data-nom');
                
                // Mettre à jour le contenu de la modal
                document.getElementById('activityName').textContent = activityName;
                document.getElementById('confirmDelete').href = 'delete-activity?id=' + activityId;
            });
        }
    </script>
</body>
</html>
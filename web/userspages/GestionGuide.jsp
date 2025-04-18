<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulaire de guide - Administration</title>
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
        
        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: #6c757d;
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
            <a href="AdminDashbord.jsp">
                <i class="bi bi-speedometer2"></i> Tableau de bord
            </a>
            <a href="GestionActivities.jsp">
                <i class="bi bi-list-check"></i> Activités
            </a>
            <a href="guides" class="active">
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
                        <c:when test="${empty guide.id}">Ajouter un guide</c:when>
                        <c:otherwise>Modifier un guide</c:otherwise>
                    </c:choose>
                </h1>
                <p class="text-muted">
                    <c:choose>
                        <c:when test="${empty guide.id}">Créez un nouveau guide dans la base de données</c:when>
                        <c:otherwise>Modifiez les détails du guide</c:otherwise>
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
                    <form id="guideForm" action="save-guide" method="POST">
                        <c:if test="${not empty guide.id}">
                            <input type="hidden" name="id" value="${guide.id}">
                        </c:if>
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="nom" class="form-label">Nom</label>
                                <input type="text" class="form-control" id="nom" name="nom" value="${guide.nom}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="prenom" class="form-label">Prénom</label>
                                <input type="text" class="form-control" id="prenom" name="prenom" value="${guide.prenom}" required>
                            </div>
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" value="${guide.email}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="motDePasse" class="form-label">Mot de passe</label>
                                <input type="password" class="form-control" id="motDePasse" name="motDePasse" 
                                    <c:if test="${empty guide.id}">required</c:if>>
                                <c:if test="${not empty guide.id}">
                                    <small class="form-text text-muted">Laissez vide pour conserver le mot de passe actuel</small>
                                </c:if>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Langues parlées</label>
                            <div class="row">
                                <c:set var="languages" value="${['Français', 'Anglais', 'Espagnol', 'Allemand', 'Italien']}" />
                                <c:forEach var="language" items="${languages}">
                                    <div class="col-md-3 mb-2">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" value="${language}" id="lang-${language}" name="langues" 
                                                <c:if test="${not empty guide.langues && guide.langues.contains(language)}">checked</c:if>
                                                <c:if test="${empty guide.langues && language eq 'Français'}">checked</c:if>>
                                            <label class="form-check-label" for="lang-${language}">${language}</label>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-between mt-4">
                            <a href="guides" class="btn btn-outline-secondary">Annuler</a>
                            <button type="submit" class="btn btn-primary">
                                <c:choose>
                                    <c:when test="${empty guide.id}">Créer</c:when>
                                    <c:otherwise>Mettre à jour</c:otherwise>
                                </c:choose>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- Liste des guides -->
            <div class="card mt-4">
                <div class="card-header bg-white p-3">
                    <h5 class="mb-0">Liste des guides</h5>
                </div>
                <div class="card-body p-0">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr class="bg-light">
                                <th class="ps-4 py-3">Nom</th>
                                <th class="py-3">Prénom</th>
                                <th class="py-3">Email</th>
                                <th class="py-3">Langues</th>
                                <th class="text-end pe-4 py-3">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty allGuides}">
                                    <tr>
                                        <td colspan="5" class="text-center py-4">Aucun guide trouvé</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="guideItem" items="${allGuides}">
                                        <tr>
                                            <td class="ps-4 py-3">${guideItem.nom}</td>
                                            <td class="py-3">${guideItem.prenom}</td>
                                            <td class="py-3">${guideItem.email}</td>
                                            <td class="py-3">
                                                <c:forEach var="langue" items="${guideItem.langues}" varStatus="status">
                                                    ${langue}<c:if test="${!status.last}">, </c:if>
                                                </c:forEach>
                                            </td>
                                            <td class="text-end pe-4 py-3">
                                                <a href="guide-form?id=${guideItem.id}" class="btn btn-outline-primary btn-sm me-2" style="width: 38px; height: 38px; border-radius: 4px; display: inline-flex; align-items: center; justify-content: center;">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <button class="btn btn-outline-danger btn-sm" 
                                                        style="width: 38px; height: 38px; border-radius: 4px; display: inline-flex; align-items: center; justify-content: center;"
                                                        data-bs-toggle="modal" 
                                                        data-bs-target="#deleteModal" 
                                                        data-id="${guideItem.id}"
                                                        data-nom="${guideItem.nom} ${guideItem.prenom}">
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
    
    <!-- Delete Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Confirmer la suppression</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Êtes-vous sûr de vouloir supprimer le guide <span id="guideName"></span> ? Cette action ne peut pas être annulée.</p>
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
                const guideId = button.getAttribute('data-id');
                const guideName = button.getAttribute('data-nom');
                
                // Mettre à jour le contenu de la modal
                document.getElementById('guideName').textContent = guideName;
                document.getElementById('confirmDelete').href = 'delete-guide?id=' + guideId;
            });
        }
    </script>
</body>
</html>
package entities;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "guides")
public class Guide extends User {

    private String langue;

    @OneToMany(mappedBy = "guide", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ActiviteTouristique> activites;

    public Guide() {
    }

    public Guide(String langue, String nom, String prenom, String email, String motDePasse) {
        super(nom, prenom, email, motDePasse);
        this.langue = langue;
    }

    public String getLangue() {
        return langue;
    }

    public void setLangue(String langue) {
        this.langue = langue;
    }

    public List<ActiviteTouristique> getActivites() {
        return activites;
    }

    public void setActivites(List<ActiviteTouristique> activites) {
        this.activites = activites;
    }
}

package entities;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class ReservationActivityId implements Serializable {

    private int ActiviteTouristiqueId;

    @Column(name = "touriste_id")
    private int touristeId;

    public ReservationActivityId() {
    }

    public ReservationActivityId(int ActiviteTouristiqueId, int touristeId) {
        this.ActiviteTouristiqueId = ActiviteTouristiqueId;
        this.touristeId = touristeId;
    }

    public int getActiviteTouristiqueId() {
        return ActiviteTouristiqueId;
    }

    public void setActiviteTouristiqueId(int ActiviteTouristiqueId) {
        this.ActiviteTouristiqueId = ActiviteTouristiqueId;
    }

    public int getTouristeId() {
        return touristeId;
    }

    public void setTouristeId(int touristeId) {
        this.touristeId = touristeId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        ReservationActivityId that = (ReservationActivityId) o;

        if (ActiviteTouristiqueId != that.ActiviteTouristiqueId) {
            return false;
        }
        return touristeId == that.touristeId;
    }

    @Override
    public int hashCode() {
        int result = ActiviteTouristiqueId;
        result = 31 * result + touristeId;
        return result;
    }

}

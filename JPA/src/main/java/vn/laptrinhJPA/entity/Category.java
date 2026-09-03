package vn.laptrinhJPA.entity;

import java.io.Serial;
import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Column;

@Entity
@Table(name = "Category")
public class Category implements Serializable {

	@Serial
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "cate_id")
	private int cateId;

	@Column(name = "cate_name", nullable = false, length = 255)
	private String cateName;

	@Column(name = "icons", length = 255)
	private String icons;

	public Category() {
	}

	public Category(String cateName, String icons) {
		this.cateName = cateName;
		this.icons = icons;
	}
	
	// Getter và Setter cho cateId
    public int getCateId() {
        return cateId;
    }

    public void setCateId(int cateId) {
        this.cateId = cateId;
    }

    // Getter và Setter cho cateName
    public String getCateName() {
        return cateName;
    }

    public void setCateName(String cateName) {
        this.cateName = cateName;
    }

    // Getter và Setter cho icons
    public String getIcons() {
        return icons;
    }

    public void setIcons(String icons) {
        this.icons = icons;
    }
}


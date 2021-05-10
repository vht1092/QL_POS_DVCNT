
package entity;

public class Pos implements java.io.Serializable{
    private String dongmay;
    private String soseri;
    private String mataisan;
    private String sototrinh;
    private Integer ngaynhapkho;
        
    public String getDongmay() {
        return this.dongmay;
    }

    public void setDongmay(String dongmay) {
        this.dongmay = dongmay;
    }
    
    public String getSoseri() {
        return this.soseri;
    }

    public void setSoseri(String soseri) {
        this.soseri = soseri;
    }
    
    public String getMataisan() {
        return this.mataisan;
    }

    public void setMataisan(String mataisan) {
        this.mataisan = mataisan;
    }
    
    public String getSototrinh() {
        return this.sototrinh;
    }

    public void setSototrinh(String sototrinh) {
        this.sototrinh = sototrinh;
    }
    
    public Integer getNgaynhapkho() {
        return this.ngaynhapkho;
    }

    public void setNgaynhapkho(Integer ngaynhapkho) {
        this.ngaynhapkho = ngaynhapkho;
    }
}

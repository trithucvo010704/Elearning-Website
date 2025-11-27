package com.example.elearning_api.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "vnpay")
public class VnPayConfig {

    /**
     * URL thanh toán của VNPAY, ví dụ:
     * https://sandbox.vnpayment.vn/paymentv2/vpcpay.html
     */
    private String payUrl;

    /**
     * TmnCode do VNPAY cấp
     */
    private String tmnCode;

    /**
     * Chuỗi bí mật dùng để ký HMAC SHA512
     */
    private String hashSecret;

    /**
     * URL để VNPAY redirect về sau khi thanh toán
     */
    private String returnUrl;

    /**
     * Phiên bản API VNPAY, thường là 2.1.0
     */
    private String version = "2.1.0";

    /**
     * Lệnh, thường là "pay"
     */
    private String command = "pay";

    /**
     * Đơn vị tiền tệ, thường là VND
     */
    private String currCode = "VND";

    /**
     * Locale: "vn" hoặc "en"
     */
    private String locale = "vn";

    // ==== getters & setters ====

    public String getPayUrl() {
        return payUrl;
    }

    public void setPayUrl(String payUrl) {
        this.payUrl = payUrl;
    }

    public String getTmnCode() {
        return tmnCode;
    }

    public void setTmnCode(String tmnCode) {
        this.tmnCode = tmnCode;
    }

    public String getHashSecret() {
        return hashSecret;
    }

    public void setHashSecret(String hashSecret) {
        this.hashSecret = hashSecret;
    }

    public String getReturnUrl() {
        return returnUrl;
    }

    public void setReturnUrl(String returnUrl) {
        this.returnUrl = returnUrl;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getCommand() {
        return command;
    }

    public void setCommand(String command) {
        this.command = command;
    }

    public String getCurrCode() {
        return currCode;
    }

    public void setCurrCode(String currCode) {
        this.currCode = currCode;
    }

    public String getLocale() {
        return locale;
    }

    public void setLocale(String locale) {
        this.locale = locale;
    }
}

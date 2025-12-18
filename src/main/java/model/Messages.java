package model;

public class Messages {
    private int chat_id;
    private String from_user;
    private String to_user;
    private String message;
    private String chat_time;

    public Messages() {}

    public int getChat_id() {
        return chat_id;
    }

    public void setChat_id(int chat_id) {
        this.chat_id = chat_id;
    }

    public String getFrom_user() {
        return from_user;
    }

    public void setFrom_user(String from_user) {
        this.from_user = from_user;
    }

    public String getTo_user() {
        return to_user;
    }

    public void setTo_user(String to_user) {
        this.to_user = to_user;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getChat_time() {
        return chat_time;
    }

    public void setChat_time(String chat_time) {
        this.chat_time = chat_time;
    }

    public Messages(int chat_id, String from_user, String to_user, String message, String chat_time) {
        this.chat_id = chat_id;
        this.from_user = from_user;
        this.to_user = to_user;
        this.message = message;
        this.chat_time = chat_time;
    }

    @Override
    public String toString() {
        return "Messages{" +
                "chat_id=" + chat_id +
                ", from_user='" + from_user + '\'' +
                ", to_user='" + to_user + '\'' +
                ", message='" + message + '\'' +
                ", chat_time='" + chat_time + '\'' +
                '}';
    }
}

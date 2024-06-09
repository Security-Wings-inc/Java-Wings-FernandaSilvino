package Slack;
import com.slack.api.Slack;
import com.slack.api.methods.SlackApiException;
import org.slf4j.LoggerFactory;

import java.io.IOException;

public class PublishingMessage {


    static void publishMessage(String id, String text) {

        String token = "xoxb-6946748837668-6957404982819-Dn9u5YHpvtP4VT3Vv1VoADVr";

        var client = Slack.getInstance().methods();
        var logger = LoggerFactory.getLogger("my-awesome-slack-app");
        try {
            var result = client.chatPostMessage(r -> r

                            .token(token)
                            .channel(id)
                            .text(text)

            );


        } catch (IOException | SlackApiException e) {

        }
    }
}

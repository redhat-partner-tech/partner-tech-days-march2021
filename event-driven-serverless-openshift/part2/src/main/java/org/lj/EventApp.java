package org.lj;

import org.jboss.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.inject.Inject;
import org.eclipse.microprofile.reactive.messaging.Channel;
import org.eclipse.microprofile.reactive.messaging.Emitter;

import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/events")
public class EventApp extends HttpServlet{
  private static final Logger LOG = Logger.getLogger(EventApp.class);
  
  @Inject
  @Channel("slack")
  Emitter<SlackMessage> slackEmitter;

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {    
	  //Pull variables we care about from the request. 
	  //All possible variables are listed out here: https://api.slack.com/interactivity/slash-commands#app_command_handling
	  String inputText = request.getParameter("text");
	  String userID = request.getParameter("user_id");
	  String sourceChannelID = request.getParameter("channel_id");
	  
	  //Translate the input text into PigLatin.
	  String outputText = PigLatin.translateToPigLatin(inputText);
	  
	  //Set up the message to go to the admin channel in the format:
	  //User [UserID] sent `/piglatin [inputText]` to channel [channelID]. [inputText] was translated to [outputText].
	  String adminMessage = "User <@" + userID + "> sent `/piglatin " + inputText + "` to channel <#" + sourceChannelID
		  + ">. `" + inputText + "` was translated to `" + outputText + "`.";
	  
	  //Send the message in the format text: message to Kafka so it gets to the Admin :eyes: channel.
	  SlackMessage slackMessage = new SlackMessage(adminMessage);
	  slackEmitter.send(slackMessage);
	 
	  //Send the translated message back.
	  PrintWriter writer = response.getWriter();   
	  writer.print(outputText);
	  writer.close();
  }
}

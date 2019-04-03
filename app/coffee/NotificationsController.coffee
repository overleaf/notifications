Notifications = require("./Notifications")
logger = require("logger-sharelatex")
metrics = require('metrics-sharelatex')

module.exports =

	getUserNotifications: (req, res)->
		logger.log user_id: req.params.user_id, "getting user unread notifications"
		metrics.inc "getUserNotifications"
		Notifications.getUserNotifications req.params.user_id, (err, notifications)->
			res.json(notifications)

	addNotification: (req, res)->
		logger.log user_id: req.params.user_id, notification:req.body, "adding notification"
		metrics.inc "addNotification"
		Notifications.addNotification req.params.user_id, req.body, (err, notifications)->
			if err?
				res.send 500
			else
				res.send()

	removeNotificationId: (req, res)->
		logger.log user_id: req.params.user_id, notification_id: req.params.notification_id, "mark id notification as read"
		metrics.inc "removeNotificationId"
		Notifications.removeNotificationId req.params.user_id, req.params.notification_id, (err, notifications)->
			res.send()

	removeNotificationKey: (req, res)->
		logger.log user_id: req.params.user_id, notification_key: req.body.key, "mark key notification as read"
		metrics.inc "removeNotificationKey"
		Notifications.removeNotificationKey req.params.user_id, req.body.key, (err, notifications)->
			res.send()

  # custom mark as read to search by university_id message opt
	removeNotificationIpMatcher: (req, res)->
		logger.log user_id: req.params.user_id, query: req.params.university_id, "mark notification as read by university id"
		metrics.inc "removeNotificationKey"
		Notifications.removeNotificationIpMatcher req.params.user_id, req.params.university_id, (err, notifications)->
			res.send()

	removeNotificationByKeyOnly: (req, res)->
		notification_key = req.params.key
		logger.log {notification_key}, "mark notification as read by key only"
		metrics.inc "removeNotificationKey"
		Notifications.removeNotificationByKeyOnly notification_key, (err, notifications)->
			res.send()

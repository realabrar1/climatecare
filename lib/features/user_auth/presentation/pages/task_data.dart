// task_data.dart

class TaskData {
  static Map<String, List<String>> weeklyTasks = {
    'Mon': [
      '1. Unplug all electronics not in use 🔌',
      '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
      '3. Swap out one incandescent lightbulb 💡 for an LED',
      '4. Take a shorter shower 🚿',
      '5. Air dry dishes instead of using the dishwasher'
    ],
    'Tue': [
      '1. Bring reusable bags to the grocery store 🛍️',
      '2. Start a compost bin 🗑️ for food scraps',
      '3. Recycle ♻️ paper, plastic, and glass',
      '4. Avoid single-use plastics',
      '5. Pack a reusable lunch'
    ],
    // Add tasks for other days...
  };

  static List<String> getTasksForDay(String day) {
    return weeklyTasks[day] ?? [];
  }
}

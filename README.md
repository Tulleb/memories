# Memories

## Share memories with your friends!

Welcome to Memories, an app where you can merge all your memories together and share them with your friends.
Track back your best memories and exchange with your friends for each one of them.

---

## Feedback

Within the given 4 hours, I chose to mainly focus on code quality, opting for an MVVM + dependency injection architecture. I also wanted to concentrate on some imaginative UX features, such as specific UI components, a parallax effect, and scrolling to reveal pictures. I ended up setting the sharing functionality aside (the Share button does nothing) as I did not have time to implement it. I thought it would be more impactful to focus on other key features. I did not write any unit tests, as they were not a priority, in my opinion, given the timeframe.

If I were given more time to continue working on Memories, I would then:
- *Sharing*: Develop the Share button feature so you could create a new memory associated to one or more friends.
- *Chat dependency*: Implement the conversation feature using its own dependency. I could then use Combine (maybe `AsyncThrowingStream`) or a better match than what was first proposed.
- *Hash tags*: Attach each memory to some hashtags, instead of attaching them to friends. It would allow users to navigate through the app using keywords they like.
- *Stories*: Add a story feature to transition smoothly from one memory to another.
- *UI/UX*: Continue improving the existing screens. I would focus on navigation animations so that screens transition not by being pushed from right to left but by zooming into the displayed pictures instead.

I hope you will enjoy checking out Memories as much as I enjoyed developing it.

---

# Voodoo iOS Founding Engineer Test

## Project Overview

Welcome. This challenge is designed to evaluate your technical skills, creativity, 
and ability to deliver a compelling product in terms of both user interface (UI) and user experience (UX) in a limited time.

You will be working on an app to share photos and chat with friends:
- *User problem*: apps such as Instagram and Snapchat have become public façades where I share highly curated pictures. I can share raw, fun pictures with my friends and chat on apps like WhatsApp, but they’re not really photo-centric.
- *Job to be done*: 1/ share ‘real’ pictures with close friends and chat, 2/ keep a shared collection of common memories.

This project is set up as a bootstrap that you will need to complete within 4 hours.


## Objectives

Your main objectives are to:

- *Implement Core Features:* build out the key functionalities of the photo-centric and chat application.
- *Focus on UI/UX:* design and implement a user interface that is intuitive, simple, and visually appealing. We're looking for innovation in how users interact with the app.
- *Write Clean Code:* ensure your code is clean, well-organized, and performance-optimized.

Feel free to implement any additional features you believe would enhance the application. Bonus functionalities are highly encouraged and welcomed.

## Key Features to Implement

- Photo Gallery: users should be able to view a collection of photos fetched from the Unsplash API (feel free to fix & improve the proposed implementation).
- Photo Selection: implement a creative and user-friendly interface for selecting and sharing photos.
- Chat Interface: design and implement a prototype of a chat feature where users can send messages and share photos (without necessary being connected to a real backend).


## Evaluation Criteria

You will be evaluated on:

- UI/UX Innovation: creativity in the app design and user interaction.
- Technical Proficiency: effective use of iOS technologies and coding best practices.
- Problem Solving: ability to address challenges with efficient solutions.

## Getting Started

- Review the project structure and the placeholders for the core features.
- Implement the features as outlined, focusing on UI/UX and code quality.

## Submission Guidelines

- Complete your work within 4 hours and ensure the project is error-free.
- Document any significant decisions or approaches you took.
- Submit your project via email as a zip file or a GitHub repository link.

Good luck, we're looking forward to reviewing your solution!

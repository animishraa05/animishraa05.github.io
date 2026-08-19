---
title: "Conditional Probability"
topic: "engineering-mathematics"
scraped_date: [[2026-03-29]]
---

# Conditional Probability
Conditional probability refers to the likelihood of an event occurring given a specific condition or prior knowledge of another event.

It is the likelihood of an event occurring, given that another event has already occurred. In probability, this is denoted as A given B, expressed as P(A | B), indicating the probability of event A when the event B has already occurred.

### Explanation of the above carousel

> Question: What are the chances that its raining given that you carry an umbrella?Given: It rains 30% of the time You carry an umbrella 50% of the time When it rains, you carry an umbrella 80% of the time Implies (for 10 days scenario):3 out of 10 days are rainy. (since 30% of 10 = 3)5 out of 10 days you carry an umbrella. (since 50% of 10 = 5)On rainy days, you carry it 2 out of 3 days (since 80% of 3 ~ 2)Total Umbrella Days:Rainy days: 2 out of 3 Sunny days: 3 out of 7.Total umbrella days = 5 (matching the 50% probability).Conditional Probability:Out of all umbrella days (5), only 2 days were rainy.Thus, P(Rain | Carry Umbrella) = 2/5 = 40%.

Question: What are the chances that its raining given that you carry an umbrella?

Given:

- It rains 30% of the time
- You carry an umbrella 50% of the time
- When it rains, you carry an umbrella 80% of the time

Implies (for 10 days scenario):

- 3 out of 10 days are rainy. (since 30% of 10 = 3)
- 5 out of 10 days you carry an umbrella. (since 50% of 10 = 5)
- On rainy days, you carry it 2 out of 3 days (since 80% of 3 ~ 2)

Total Umbrella Days:

- Rainy days: 2 out of 3
- Sunny days: 3 out of 7.
- Total umbrella days = 5 (matching the 50% probability).

Conditional Probability:

Out of all umbrella days (5), only 2 days were rainy.Thus, P(Rain | Carry Umbrella) = 2/5 = 40%.

## Conditional Probability Formula

Let's consider two events A and B, then the formula for the conditional probability of B when A has already occurred is given by:

![programing_9](images_programing_9.webp)

Where,

- P (A ∩ B) represents the probability of both events A and B occurring simultaneously.
- P(A) represents the probability of event A occurring.

### Steps to Find Probability of One Event Given Another Has Already Occurred

To calculate the conditional probability, we can use the following step-by-step method:

> Step 1: Identify the Events. Let's call them Event A and Event B.Step 2: Determine the Probability of Event A i.e., P(A)Step 3: Determine the Probability of Event B i.e., P(B)Step 4: Determine the Probability of Event A and B i.e., P(A ∩ B).Step 5: Apply the Conditional Probability Formula and calculate the required probability.

Step 1: Identify the Events. Let's call them Event A and Event B.Step 2: Determine the Probability of Event A i.e., P(A)Step 3: Determine the Probability of Event B i.e., P(B)Step 4: Determine the Probability of Event A and B i.e., P(A ∩ B).Step 5: Apply the Conditional Probability Formula and calculate the required probability.

## Conditional Probability Examples

There are various examples of conditional probability, as in real life, where all events are related to each other, and the occurrence of any event affects the probability of another event. For example, if it rains, the probability of road accidents increases as roads have less friction.

### 1) Tossing a Coin

Let's consider two events in tossing two coins,

- A: Getting a head on the first coin.
- B: Getting a head on the second coin. Sample space for tossing two coins is:S = {HH, HT, TH, TT}

The conditional probability of getting a head on the second coin (B) given that we got a head on the first coin (A) is = P(B|A).

Since the coins are independent (one coin's outcome does not affect the other),P(B|A) = P(B) = 0.5 (50%), which is the probability of getting a head on a single coin toss.

### 2) Drawing Cards

In a deck of 52 cards where two cards are being drawn, let's consider the events.

- A: Drawing a red card on the first draw and
- B: Drawing a red card on the second draw.

The conditional probability of drawing a red card on the second draw (B) given that we drew a red card on the first draw (A) is = P(B|A)

After drawing a red card on the first draw, there are 25 red cards and 51 cards remaining in the deck. So, P(B|A) = 25/51 ≈ 0.49 (approximately 49%).

## Properties of Conditional Probability

Some of the common properties of conditional probability are:

1. Let's consider an event A in any sample space S of an experiment. P( S | A) = P(A | A) = 1

2. For any two events A and B of a sample space S and an event X such that P(X) ≠ 0, P((A ∪ B) | X) = P(A | X) + P(B | X) - P((A ∩ B) | X)

3. The order of sets or events is important in conditional probability, i.e., P(A | B) ≠ P(B | A)

4. The complement formula for probability only holds conditional probability if it is given in the context of the first argument in conditional probability, i.e., P(A’ | B ) = 1 - P( A | B ) P(A | B’) ≠ 1 - P(A | B)

5: For any two or three independent events, the intersection of events can be calculated using the following formula:

- For the intersection of two events A and BP(A ⋂ B) = P(A) P(B)
- For the intersection of three events A, B, and C, P (A ⋂ B ⋂ C) = P(A) P(B) P(C)

## Conditional Probability and Independent Events

With the help of conditional probability, we can tell apart dependent and independent events. When the probability of one event happening doesn't influence the probability of any other event, then events are called independent, otherwise dependent events.

### Conditional Probability of Independent Events

When two events are independent, the conditional probability is the same as the probability of the event individually, i.e., P (A | B) is the same as P(A), as there is no effect of event B on the probability of event A. For independent events, A and B, the conditional probability of A and B concerning each other is given as follows:

- P(B | A) = P(B)
- P(A | B) = P(A)

## Conditional Probability vs Joint Probability vs Marginal Probability

The difference between Conditional Probability, Joint Probability, and Marginal Probability is given in the following table:

| Conditional Probability | Joint Probability | Marginal Probability |
| --- | --- | --- |
| The probability of an event occurring is given.That another event has already occurred. | The probability of two or more events occurring simultaneously. | The probability of an event occurring without considering any other events. |
| P (A | B) | P (A ∩ B) | P(A) |
| Two or more events | Two or more events | Single event. |

> Note: Conditional probability is widely used for [[bayes-theorem|bayes theorem]] where we update probabilities based on new evidence, for more details you can refer to: [[bayes-theorem|Bayes' Theorem]]

Note: Conditional probability is widely used for [[bayes-theorem|bayes theorem]] where we update probabilities based on new evidence, for more details you can refer to: [[bayes-theorem|Bayes' Theorem]]

## Multiplication Rule of Probability

Multiplication Rule of Probability, when applied in the context of conditional probability, helps us calculate the probability of the intersection of two events when the probability of one event depends on the occurrence of the other event. This rule is crucial in understanding the joint probability of events under specific conditions.

In the context of conditional probability, the Multiplication Rule is often stated as follows:

> P(A ∩ B) = P(A) × P(B ∣ A )

P(A ∩ B) = P(A) × P(B ∣ A )

Here's what each term represents:

- P(A∩B): This denotes the probability that both events A and B occur simultaneously.
- P(A): This represents the probability of event A happening.
- P(B∣A): This is the conditional probability of event B occurring given that event A has already occurred.

### How to Apply the Multiplication Rule?

To apply the Multiplication Rule in the context of conditional probability, we can use the following steps:

- First, we calculate the probability of event A occurring.
- Then, we compute the probability of event B occurring given that event A has occurred.
- Multiplying these probabilities together gives us the joint probability of both events happening under the specified conditions.
- This rule is particularly useful when dealing with events that are not independent, meaning that the occurrence of one event affects the probability of the other event.

## Applications of Conditional Probability

Various applications of conditional probability are,

Finance and Risk Management

- Example: Assessing the probability of default for a borrower given certain financial indicators.
- Application: Banks and financial institutions use conditional probability to evaluate the risk associated with loans and investments.

Healthcare and Diagnostics

- Example: Determining the probability of a patient having a specific disease given the results of diagnostic tests.
- Application: Conditional probability is crucial in medical diagnoses and decision-making, helping healthcare professionals make informed decisions based on [[test]] results.

Marketing and Customer Relationship Management (CRM)

- Example: Predicting the probability of a customer making a purchase based on their past buying behavior.
- Application: Businesses use conditional probability to tailor marketing strategies, optimize customer experiences, and personalize product recommendations.

Machine Learning and Artificial Intelligence

- Example: Predicting the likelihood of a user clicking on a particular ad based on their online behavior.
- Application: Conditional probability is fundamental in machine learning algorithms for tasks such as classification, recommendation systems, and natural language processing.

Weather Forecasting

- Example: Estimating the probability of rain tomorrow given today's weather conditions.
- Application: Meteorologists use conditional probability to make weather predictions based on historical data and current atmospheric conditions.

## Solved Examples of Conditional Probability

Question 1: A bag contains 5 red balls and 7 blue balls. Two balls are drawn without replacement. What is the probability that the second ball drawn is red, given that the first ball drawn was red?Solution:

> Let the events be,Event A: The first ball drawn is red.Event B: The second ball drawn is red.P(A) = 5/12 and P(B) = 4/11 (as first ball drawn is already red, thus only 4 red balls remain in the bag)Therefore, probability of the second ball drawn being red given that the first ball drawn was red is 4/11.

Let the events be,

Event A: The first ball drawn is red.Event B: The second ball drawn is red.

P(A) = 5/12 and P(B) = 4/11 (as first ball drawn is already red, thus only 4 red balls remain in the bag)

Therefore, probability of the second ball drawn being red given that the first ball drawn was red is 4/11.

Question 2: In a survey among a group of students, 70% play football, 60% play basketball, and 40% play both sports. If a student is chosen at random and it is known that the student plays basketball, what is the probability that the student also plays football?Solution:

> Let's assume there are 100 students in the survey.Number of students who play football = n(A) = 70Number of students who play basketball = n(B) = 60Number of students who play both sports = n(A ∩ B) = 40To find the probability that a student plays football given that they play basketball, we use the conditional probability formula:P(A|B) = n(A ∩ B) / n(B)Substituting the values, we get:P(A|B) = 40 / 60 = 2/3Therefore, probability that a randomly chosen student who plays basketball also plays football is 2/3.

Let's assume there are 100 students in the survey.

Number of students who play football = n(A) = 70Number of students who play basketball = n(B) = 60Number of students who play both sports = n(A ∩ B) = 40

To find the probability that a student plays football given that they play basketball, we use the conditional probability formula:P(A|B) = n(A ∩ B) / n(B)

Substituting the values, we get:P(A|B) = 40 / 60 = 2/3

Therefore, probability that a randomly chosen student who plays basketball also plays football is 2/3.

Question 3: A fair die is rolled twice. Given that the sum of the two rolls is even, what is the probability that the first roll was an even number?Solution:

> Total favorable outcomes for an even sum:Both rolls even: 9 outcomes (e.g., (2, 2), (2, 4), ...)Both rolls odd: 9 outcomes (e.g., (1, 1), (1, 3), ...)Total = 18 outcomes.Favorable outcomes where the first roll is even:First roll even (2, 4, 6), second roll even (2, 4, 6): 9 outcomes.Conditional probability: P(First roll even | Sum even) = 9 / 18 = 1 / 2

Total favorable outcomes for an even sum:

Both rolls even: 9 outcomes (e.g., (2, 2), (2, 4), ...)

Both rolls odd: 9 outcomes (e.g., (1, 1), (1, 3), ...)

Total = 18 outcomes.

Favorable outcomes where the first roll is even:

First roll even (2, 4, 6), second roll even (2, 4, 6): 9 outcomes.

Conditional probability: P(First roll even | Sum even) = 9 / 18 = 1 / 2

Question 4: In a bag, there are 4 red balls and 6 blue balls. Two balls are drawn without replacement. What is the probability that the second ball is red, given that the first ball drawn was blue?Solution:

> After drawing a blue ball, there are 4 red balls and 5 blue balls left.P(Second is red | First was blue) = 4 / (4 + 5) = 4/9 = 0.444

After drawing a blue ball, there are 4 red balls and 5 blue balls left.P(Second is red | First was blue) = 4 / (4 + 5) = 4/9 = 0.444

## Unsolved Question of Conditional Probability

Question 1: A deck of cards has 52 cards, with 13 cards in each suit( hearts, diamonds, clubs, and spades). Two cards are drawn without replacement. What is probablility that the second card drawn is a heart, given that the first card drawn was a heart?

Question 2: In a survey of 100 people who like ice cream, 50 people like cake, and like 20 people like both ice cream and cake. If a person is chosen at random and it is known that they like ice cream, what is the probability that they also like cake?

Question 3: A box contains 6 red balls and 4 green balls. Two balls are drawn without replacement. What is the probability that the second ball is green, given that the first ball drawn was red?

Question 4: In a class of 30 students, 12 studentdre wearing glasses. A studemt us randomly selected; it is known that the student is wearing glasses. What is the probability that the student is wearing glasses? What is the probability that the student is male, given that 8 males in the class are wearing glasses?